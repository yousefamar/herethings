# HereThings

## Installation

 1. `git clone` this repo and `cd` into it
 2. `npm install --production`

If you want to compile from scratch:

 1. Same as above but `npm install`
 2. `npm run compile`

During dev, build automatically on file write with `npm run watch`. Delete build with `npm run clean` for convenience.

## Usage

To launch the web server, run `npm start` which is equivalent to `node build/server.js`.

By default, it will run on port 9980. To change that, set the PORT enviroment variable, i.e. `PORT=8080 npm start`.

Once the server is running, navigate to `localhost:9980/things` to test.

## Notes

 - All services are served by the same web server, like the original PHP, but this will probably change, since right now if the server goes down, all services do.
 - The app will detect if it's being accessed locally, and if so, all links to other services will look like `localhost:[PORT]/[SERVICE]`, otherwise `here[SERVICE].com`.
 - The plan is at [doc/plan.md](doc/plan.md); please edit there.
