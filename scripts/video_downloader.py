from pytube import YouTube
import json, os
import glob
from moviepy.video.io.ffmpeg_tools import ffmpeg_extract_subclip

json_files = glob.glob(os.path.join('./links', '*.json'))

dicts = []
for json_file in json_files:
    with open(json_file, 'r') as file:
        dicts.append(json.load(file))

for json_dict in dicts:
    for key, value in json_dict.items():
        video_dir = './videos/{}'.format(key)
        if not os.path.exists(video_dir):
            os.mkdir(video_dir)
        
        for index, youtube in value.items():
            link = youtube["link"]
            start_time = youtube["start_time"]
            end_time = youtube["end_time"]
            
            video_file = os.path.join(video_dir, '{}.mp4'.format(index))
            clip_file = os.path.join(video_dir, 'clipped_{}.mp4'.format(index))

            if not os.path.exists(video_file):
                print("Downloading {}".format(link))
                video = YouTube(link)
                video.streams.filter(progressive=True, file_extension='mp4').order_by('resolution')[-1].download(output_path=video_dir, filename=str(index))

            if not os.path.exists(clip_file):
                ffmpeg_extract_subclip(video_file, int(start_time), int(end_time), targetname=clip_file)



