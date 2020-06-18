import requests
import random
import json, glob, os

LOCAL_HOST = 'http://localhost:3000'

def user_generator(total_num):
    user_dict = {}

    with open('./db/random_names.txt', 'r') as file:
        names = file.readlines()
        
    names = [name[:-1] for name in names]
    print(len(names))
    random_indexes = random.sample(range(len(names)-1), total_num)

    for i in random_indexes:
        name = names[i]

        user_dict[str(i)] = {
            "user":{
                "username" : name,
                "nickname" : name,
                "password" : "1111",
                "profile_pic" : "dog"
            }
        }
    

    with open('./db/users.json', 'w') as file:
        json.dump(user_dict, file, indent=4)

def signup_users(json_file):
    with open(json_file, 'r') as file:
        users = json.load(file)
    
    for user in users.values():
        print(user)
        requests.post('http://localhost:3000/users', json=user)

def join_and_post_video(session, rooms_json, room_category, video_list):
    invite_code = rooms_json[room_category]

    # join a room
    response = session.patch('{}/rooms/{}'.format(LOCAL_HOST, invite_code))

    print("Joining a room: {}".format(response.status_code))

    if response.status_code != 200:
        return

    if len(video_list) > 0:
        video_path = video_list[0]
        form_data = {"clip": open(video_path, 'rb')}

        response = session.post('{}/videos/{}'.format(LOCAL_HOST, invite_code), files=form_data)
        print("Posted a video: {} \n {}".format(video_path, response.status_code))
        del video_list[0]

    

def automatic_routine():
    with open('./db/users.json', 'r') as file:
        users = json.load(file)
    
    with open('./db/rooms.json', 'r') as file:
        rooms = json.load(file)
    rooms = rooms["rooms"]

    jogging_videos = glob.glob('./videos/jogging/clipped_*')
    drawing_videos = glob.glob('./videos/drawing/clipped_*')
    cooking_videos = glob.glob('./videos/cooking/clipped_*')

    #print("LOADED VIDEOS")
    #print(jogging_videos)
    #print(drawing_videos)
    #print(cooking_videos)

    for user_wrapper in users.values():
        user = user_wrapper["user"]
        username = user["username"]
        password = user["password"]

        signin_json = {
            "user": {
                "username": username,
                "password": password
            }
        }
        session = requests.Session()
        response = session.post('http://localhost:3000/login', json=signin_json)
        
        print('Login status code: {}'.format(response.status_code))
        
        if response.status_code != 200:
            return

        random_num = random.randrange(0, 100)

        index = random_num % 3

        if index == 0:
            join_and_post_video(session, rooms, 'jogging', jogging_videos)
        elif index == 1:
            join_and_post_video(session, rooms, 'drawing', drawing_videos)
        else:
            join_and_post_video(session, rooms, 'cooking', cooking_videos)

        
        response = session.post('http://localhost:3000/logout')
        
        print("Logging out: {}".format(response.status_code))
        if response != 200:
            return

automatic_routine()
    


#user_generator(40)
#signup_users('./db/users.json')