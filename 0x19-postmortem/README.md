# Apache Server Outage Incident Report
> The following presents an incident report on the recent return of 500 status codes by a docker container running Apache and WordPress. We are deeply sorry for all inconveniences and loss caused by this outage.

## Issue Summary
Between 10:34 and 11:05 hours GMT, requests to the Apache server were returning a 500 error page. This meant that no one was able to access the site's services for the duration of the outage. At the root of this problem was a misspelling in a critical file specified in the `PHP` settings file.

## Timeline (all times in GMT and the 24-hour notation)
* 09:30: The WordPress settings file edited and pushed
* 10:34: A `curl` request was made to the server. Returns a 500 response status code detected by the engineer as shown in the following image:<br>![error response](https://github.com/coldplayz/alx-system_engineering-devops/blob/main/0x19-postmortem/error_response.jpg "Error response on curl")
* 10:37: Error logs checked for error details. Misleading, as no error logged
* 10:58: Turned on error display in the `php.ini` file
* 11:05: Error message is displayed showing a potentially misspelled filename as shown below:<br>![misspelling](https://github.com/coldplayz/alx-system_engineering-devops/blob/main/0x19-postmortem/misspelling.jpg "Misspelling")
* 11:10: Attempt is made to correct spelling in the affected file
* 11:12: Service is restored

## Root Cause and Resolution

   At 09:30 GMT, a WordPress settings file was edited to configure some settings. This change was not tested before being pushed, and coupled with a lack of monitoring setup for response status codes, this led to an outage of almost an hour.

   By 10:34 GMT, an engineer made a request to the server only to discover that it returned a 500 error page. This same engineer took on the responsibility of fixing it, so no escalation was made.

   He proceeded with resolution by first checking the Apache error log file as at 10:37 GMT, only to find no error was logged for the 500 status code. For about 20 minutes, he researched online for how to get more detail on the error for the particucular stack. By 10:58 GMT, he knew, and went on, to turn on error display for `PHP`. This enabled the display of a helpful error message (as shown below), which suggested a missplelling of the filename of a file required to be opened by the server. By 11:10 GMT, he had corrected the misspelling, and the service was back up and running.<br>![error display](https://github.com/coldplayz/alx-system_engineering-devops/blob/main/0x19-postmortem/error_display.jpg "Error display on curl")

## Corrective and Preventive Measures

   Preventing a repeat occurence would require improving the robustness of testing, and setting up a monitor for response codes. These are the corresponding actions:
   * Improve test coverage.
   * Automate testing before deploying to production.
   * Setup monitoring of status codes of server responses.

We thank you for your patience and continued support, and promise to work hard to avert a repeat of this.


_Sincerely,_
<br>_Greenbel Chibuike Eleghasim_
