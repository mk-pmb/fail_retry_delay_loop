
<!--#echo json="package.json" key="name" underline="=" -->
fail_retry_delay_loop
=====================
<!--/#echo -->

<!--#echo json="package.json" key="description" -->
Repeat a command until it succeeds, with a delay between retries.
<!--/#echo -->

* This project was originally developed at [Instaffo](https://instaffo.com/),
  a reverse recruiting service for tech jobs (and others).


Usage
-----

```text
fail_retry_delay_loop delay prog [...args]
```

* `delay`: Anything that `sleep` would accept, or
  * `env:VAR` to use the value of environment variable `$VAR` instead.
  * `-` or empty = don't repeat.
* `prog`: The program to run.
  * If it contains a dot (`.`) or slash (`/`), it's considered a local
    filename.
    * The loop exits with an error if that file isn't a regular file
      (e.g. doesn't exist).
    * For some filename extensions, the file is run with an interpreter
      if it's not executable.
* `args`: Optional arguments for the program.



Use as npm dep
--------------

```bash
npm i --save 'git+https://github.com/mk-pmb/fail_retry_delay_loop.git#master'
```


<!--#toc stop="scan" -->


&nbsp;


License
-------
<!--#echo json="package.json" key=".license" -->
MIT
<!--/#echo -->
