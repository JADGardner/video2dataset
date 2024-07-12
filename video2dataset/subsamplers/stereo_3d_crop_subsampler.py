import os
import ffmpeg
import tempfile
import json
from .subsampler import Subsampler

class Stereo3DCropSubsampler(Subsampler):
    def __init__(self, some_arg: int = 1, encode_format: str = "mp4"):
        self.some_arg = some_arg
        self.encode_format = encode_format
        self.encode_formats = {
            'video': encode_format
        }

    def get_stereo3d_type(self, metadata):
        """Get the stereo 3D type of a video"""
        # try:
        #     probe = ffmpeg.probe(video_path)
        #     print(probe)
        #     for stream in probe['streams']:
        #         for side_data in stream.get('side_data', []):
        #             if side_data.get('side_data_type') == 'Stereo3D':
        #                 return side_data.get('type')
        #     return None
        # except ffmpeg.Error:
        #     return None
        return metadata[0]['video_metadata']['streams'][0]['side_data_list'][0]['type']

    def __call__(self, streams, metadata=None):
        # print("Subsampling stereo 3D video")
        video_bytes = streams["video"]
        subsampled_bytes = []
        for vid_bytes in video_bytes:
            with tempfile.TemporaryDirectory() as tmpdir:
                input_path = os.path.join(tmpdir, f"input.{self.encode_format}")
                output_path = os.path.join(tmpdir, f"output.{self.encode_format}")
                
                with open(input_path, "wb") as f:
                    f.write(vid_bytes)
                
                stereo3d_type = self.get_stereo3d_type(metadata)
                # print(f"Stereo 3D type: {stereo3d_type}")
                
                try:
                    _ = ffmpeg.input(input_path)
                    if stereo3d_type == 'top and bottom':
                        # Crop the top half of the video
                        _ = _.filter('crop', x=0, y=0, w='iw', h='ih/2')
                    
                    _ = _.output(output_path, reset_timestamps=1).run(capture_stdout=True, quiet=True)
                except Exception as err:  # pylint: disable=broad-except
                    return [], None, str(err)

                with open(output_path, "rb") as f:
                    subsampled_bytes.append(f.read())
        
        streams["video"] = subsampled_bytes
        return streams, metadata, None