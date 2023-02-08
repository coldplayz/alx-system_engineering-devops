#!/usr/bin/python3
''' Using the `https://jsonplaceholder.typicode.com/` REST API, returns
information about the TODO list progress of a given employee/user.

Export data in the CSV format.
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

    # Export to csv
    for dct in jsn:
        title = dct.get('title')
        with open('{}.csv'.format(userId), 'a', encoding='utf-8') as fout:
            task_str = '"{}","{}","{}","{}"\n'.format(
                    userId, userName,
                    "True" if dct.get('completed') else "False", title)
            fout.write(task_str)
