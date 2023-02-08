#!/usr/bin/python3
''' Using the `https://jsonplaceholder.typicode.com/` REST API, returns
information about the TODO list progress of a given employee/user.

Export data in the CSV format.
'''
import csv
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

    # Export to csv
    fmt = ['USER_ID', 'USERNAME', 'TASK_COMPLETED_STATUS', 'TASK_TITLE']
    for dct in jsn:
        title = dct.get('title')
        with open(
                '{}.csv'.format(
                    userId), 'a', encoding='utf-8', newline='') as csvfile:
            task_dict = {
                    'USER_ID': userId,
                    'USERNAME': userName,
                    'TASK_COMPLETED_STATUS': "True" if dct.get(
                        'completed') else "False",
                    'TASK_TITLE': title
                    }
            writer = csv.DictWriter(
                    csvfile, fieldnames=fmt, quoting=csv.QUOTE_ALL)
            writer.writerow(task_dict)
