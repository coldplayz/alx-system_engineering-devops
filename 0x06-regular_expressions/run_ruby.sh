#!/usr/bin/env bash


while read line
do
	./100-textme.rb "$line"
done < text_messages.log
