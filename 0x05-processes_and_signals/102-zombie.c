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
	pid_t pid;
	int i;

	for (i = 0; i < 5; i++)
	{
		pid = fork();
		printf("Zombie process created, PID: %d\n", pid);
	}

	infinite_while();

	return (0);
}
