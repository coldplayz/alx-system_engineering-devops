# Load Balancer
Integrating a load balancer in front of two web servers.

* 0-custom_http_response_header: configures Nginx so that its HTTP response contains a custom header (on web-01 and web-02) - X-Served-By.

* 1-install_load_balancer: installs and configure HAproxy on your lb-01 server.


