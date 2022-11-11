#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

/**
 * infinite_while - loops infinitely.
 *
 * Return: 0 always.
 */
int infinite_while(void)
{
	while (1)
	{
		sleep(1);
	}

	return (0);
}

/**
 * main - creates 5 zombies.
 *
 * Return: 0 always.
 */
int main(void)
{
	pid_t pid, pid2;
	int i;

	pid2 = getpid(); /* of current process */
	for (i = 0; i < 5; i++)
	{
		if (getpid() == pid2)
		{
			pid = fork();
			if (getpid() == pid2)
			{
				printf("Zombie process created, PID: %d\n", pid);
			}
		}
	}
	if (getpid() == pid2)
	{
		infinite_while();
	}

	return (0);
}
