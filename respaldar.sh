
#!/bin/bash
# Daily report bash script
# This generate daily-report file for project, where it .sh will be executed
# For use move it to your project folder and exec in terminal:
# +x ; ./report.sh 

DEBUG=0
directoryName="reports"

getName() {
	git config user.name || getent passwd $(id -un) | cut -d : -f 5 | cut -d , -f 1
}

wd=$(pwd)

projectName=$(basename "$PWD")
currentDate=$(LC_TIME=ru_RU date "+%d %B %Y (%A)")
userName=$(getName)
yesterdayReport=$(git log --pretty=format:">• %s" --after=yesterday.midnight --before=today.midnight --author=$userName)

if [ "$DEBUG" = true ] ; then 
	echo "App: $projectName"
	echo "Developer: $userName"
	echo "Directory reports: $directoryName"
fi

# create folder for save reports and move into
if [ ! -d "$directoryName" ]; then
	mkdir ${directoryName}
fi

cd reports

{
echo "*$currentDate*"
echo 
echo "*1. Done*"
echo "> *$projectName*"
# execute git log yesterday
git log --pretty=format:">• %s" --after=yesterday.midnight --before=today.midnight --author=${userName}
echo
echo
echo "*2. TODO*"
echo "> *$projectName*"
echo ">• "
echo 
echo "*3. Problems*"
echo ">• -"
} > "$currentDate.txt"