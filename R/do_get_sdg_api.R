do_get_sdg_api <- function(
    output = "data_derived/sdg_14.csv"
){
  # (Client URL) command line tool that enables data exchange between a device 
  # and a server through a terminal
  curl <- paste0(
    'curl -X POST',
    '--header "Content-Type: application/x-www-form-urlencoded" ',
    '--header "Accept: application/octet-stream" ',
    '-d "goal=14" ',
    '"https://unstats.un.org/sdgapi/v1/sdg/Goal/DataCSV" -o', 
    output)
  
  # Execute cURL
  system(curl)
}

# POST request: is used to send data to the server to create or update a resource.

#--header "Content-Type: application/x-www-form-urlencoded":
# Sets the Content-Type header to application/x-www-form-urlencoded, 
# which means the data is being sent as URL-encoded form data.

# --header "Accept: application/octet-stream": 
#   Sets the Accept header to application/octet-stream, 
# indicating that the client expects a binary file as a response.

# -d "goal=14": Sends the data goal=14 in the POST request.

# "https://unstats.un.org/sdgapi/v1/sdg/Goal/DataCSV":
# The URL to which the POST request is being sent.

# -o output: Saves the response to a file named output.