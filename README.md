# HereThings

## Installation

 1. `git clone` this repo and `cd` into it
 2. `npm install`
 3. `npm run compile`

During dev, build automatically on file write with `npm run watch` (or `npm run watch-win` on windows). Delete build with `npm run clean` for convenience.

## Usage

To launch the web server, run `npm start` which is equivalent to `node build/server.js`. For debug, `nodemon` is recommended, and for production, `forever`.

By default, it will run on port 8080. To change that, set the PORT enviroment variable, i.e. `PORT=8081 npm start`.

Once the server is running, navigate to `localhost:8080/things` to test.

## Notes

 - All services are served by the same web server, like the original PHP, but this will probably change, since right now if the server goes down, all services do.
 - The app will detect if it's being accessed locally, and if so, all links to other services will look like `localhost:[PORT]/[SERVICE]`, otherwise `here[SERVICE].com`.
 - All resources automatically have a content hash appended to their URL for cache busting.
 - The plan is at [doc/plan.md](doc/plan.md); please edit there.
