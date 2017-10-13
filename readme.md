# Reading the Manual

A Rack application is a Ruby object (not a class) that responds to `call`. It takes exactly one argument, the environment and returns an Array of exactly three values: The **status**, the **headers**, and the **body**.

## The Spec
[SPEC](http://www.rubydoc.info/github/rack/rack/file/SPEC) provides important specifics and should be reviewed by you, if you're actually still reading this :smile:

### The Environment
The environment must be an instance of Hash that includes CGI-like headers. The application is free to modify the environment. The environment is required to include these variables (adopted from PEP333), except when they'd be empty, but see below.

#### REQUEST_METHOD
The HTTP request method, such as “GET” or “POST”. This cannot ever be an empty string, and so is always required.

#### SCRIPT_NAME
The initial portion of the request URL's “path” that corresponds to the application object, so that the application knows its virtual “location”. This may be an empty string, if the application corresponds to the “root” of the server.

#### PATH_INFO
The remainder of the request URL's “path”, designating the virtual “location” of the request's target within the application. This may be an empty string, if the request URL targets the application root and does not have a trailing slash. This value may be percent-encoded when originating from a URL.

#### QUERY_STRING
The portion of the request URL that follows the ?, if any. May be empty, but is always required!

#### SERVER_NAME, SERVER_PORT
When combined with SCRIPT_NAME and PATH_INFO, these variables can be used to complete the URL. Note, however, that HTTP_HOST, if present, should be used in preference to SERVER_NAME for reconstructing the request URL. SERVER_NAME and SERVER_PORT can never be empty strings, and so are always required.

#### HTTP_ Variables
Variables corresponding to the client-supplied HTTP request headers (i.e., variables whose names begin with HTTP_). The presence or absence of these variables should correspond with the presence or absence of the appropriate HTTP header in the request. See RFC3875 section 4.1.18 for specific behavior.

_In addition to this, the Rack environment must include these Rack-specific variables:_

#### rack.version
The Array representing this version of Rack See Rack::VERSION, that corresponds to the version of this SPEC.

#### rack.url_scheme
http or https, depending on the request URL.

#### rack.input
See below, the input stream.

#### rack.errors
See below, the error stream.

#### rack.multithread
true if the application object may be simultaneously invoked by another thread in the same process, false otherwise.

#### rack.multiprocess
true if an equivalent application object may be simultaneously invoked by another process, false otherwise.

#### rack.run_once
true if the server expects (but does not guarantee!) that the application will only be invoked this one time during the life of its containing process. Normally, this will only be true for a server based on CGI (or something similar).

#### rack.hijack?
present and true if the server supports connection hijacking. See below, hijacking.

#### rack.hijack
an object responding to #call that must be called at least once before using rack.hijack_io. It is recommended #call return rack.hijack_io as well as setting it in env if necessary.

#### rack.hijack_io
if rack.hijack? is true, and rack.hijack has received #call, this will contain an object resembling an IO. See hijacking.

## Managing Requests

dealing directly with `env` is a bit tedious. `Rack::Request` is a helper wrapper that can be used instead whose only

```
request = Rack::Request.new(env)
request.path_info
request.request_method
request.body
request.env   #=> { full env hash }
```

### Example POST request

Use curl to POST a new concert

```
curl -X POST http://localhost:9292/concerts --data '{ "user_id": 1, "location": "Missoula, MT", "show": "Pearl Jam", "date": "2020-10-03" }'
```
