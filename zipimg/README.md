# zipimg.sh
add a file into an image in bash

$ wget https://raw.githubusercontent.com/bitsko/zipimg.sh/main/zipimg.sh && chmod +x zipimg.sh

usage examples:

./zipimg.sh image.png file.zip 
(add an already zipped file to a png image)

./zipimg.sh image.png file.txt
(zip the file and add it to the png)

./zipimg.sh image.jpeg file.zip
(add an already zipped file to a jpeg converted to png)

./zipimg.sh image.png file.txt -pw 
(password protect the file while zipping)



