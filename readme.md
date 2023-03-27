I am learning salt stack and documenting my progress. 

To set up this repo for yourself..

Install salt on a master and a minion

Copy the `${repopath}/salt to ${master}/srv/salt/`

Set the appropriate roles grain data:
```bash
salt '*' grains.set  roles [webserver,rhnet]
```


I've also created a wiki to cover the basic commands and setup. 
https://github.com/bobalob3/salt/wiki

