#!/usr/bin/python3
''' Using the `https://jsonplaceholder.typicode.com/` REST API, returns
information about the TODO list progress of a given employee/user.
'''
import requests
from sys import argv

if __name__ == '__main__':
    userId = argv[1]
    url_user = 'https://jsonplaceholder.typicode.com/users/{}/'.format(userId)
    url_user_todos = 'https://jsonplaceholder' +\
        '.typicode.com/users/{}/todos'.format(userId)

    # Get data for specified user
    response = requests.get(url_user)
    userName = response.json().get('name')  # retrieve user name

    # Get data on user's todos
    response = requests.get(url_user_todos)
    jsn = response.json()  # in this case, a list of dictionaries
    totalTodos = len(jsn)

    done = 0
    # Get number of tasks completed
    for dct in jsn:
        if dct.get('completed') is True:
            done += 1

    # Present data
    print('Employee {} is done with tasks({}/{}):'.format(
        userName, done, totalTodos))
    for dct in jsn:
        if dct.get('completed'):
            print('\t {}'.format(dct.get('title')))
