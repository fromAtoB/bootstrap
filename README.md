# bootstrap

Responsible for helping devs to bootstrap their local development environments.
The only pre-requisite is having git installed, all else will be installed for you.

Just run:

```sh
git clone git@github.com:fromAtoB/bootstrap.git
cd bootstrap
./bootstrap
```

It anything doesn't work out, create an issue =).
The script is idempotent (or it should =P), so if
it fails in the middle for some reason and you
want to give it another run after fixing something
(like creating a credential on GCP first) you can
just run the script again.
