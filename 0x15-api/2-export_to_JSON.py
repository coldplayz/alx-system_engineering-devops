#!/usr/bin/python3
''' Using the `https://jsonplaceholder.typicode.com/` REST API, returns
information about the TODO list progress of a given employee/user.

Export data in the JSON format.
'''
import json
import requests
from sys import argv

if __name__ == '__main__':
    userId = argv[1]
    url_user = 'https://jsonplaceholder.typicode.com/users/{}/'.format(userId)
    url_user_todos = 'https://jsonplaceholder' +\
        '.typicode.com/users/{}/todos'.format(userId)

    # Get data for specified user
    response = requests.get(url_user)
    userName = response.json().get('username')  # retrieve user name

    # Get data on user's todos
    response = requests.get(url_user_todos)
    jsn = response.json()  # in this case, a list of dictionaries
    totalTodos = len(jsn)

    # EXPORT TO JSON
    json_dict = {}
    user_task_list = []
    # Compose list of task dictionaries
    for dct in jsn:
        title = dct.get('title')
        completed = dct.get('completed')
        task_dict = {
                "task": title,
                "completed": completed,
                "username": userName
                }
        user_task_list.append(task_dict)
    # Update json dictionary
    json_dict.update({userId: user_task_list})
    # Dump to json file
    with open('{}.json'.format(userId), 'w', encoding='utf-8') as jsonFile:
        json.dump(json_dict, jsonFile)
