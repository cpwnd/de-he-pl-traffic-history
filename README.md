# ffm-parking-history

Tracking traffic data https://polizei.hessen.de

## Example Queries 

[Duration of traffic events](http://127.0.0.1:8001/de-he-pl-traffic?sql=select+%0D%0A*%2C%0D%0AROUND%28days_till_now+%2F+%28days_till_project_finish+%2F+100%29%2C+2%29+percent_done%0D%0Afrom+%28select%0D%0A++_item%2C%0D%0A++max%28verbal%29%2C%0D%0A++max%28streets%29%2C%0D%0A++ROUND%28julianday%28max%28durationEndTime%29%29+-+julianday%28max%28durationStartTime%29%29%29+as+days_till_project_finish%2C%0D%0A++--+julianday%28MAX%28durationStartTime%29%29+-+julianday%28MAX%28begin%29%29+as+days2%2C%0D%0A++ROUND%28julianday%28MAX%28_commit_at%29%29+-+julianday%28durationStartTime%29%29+as+days_till_now%0D%0Afrom%0D%0A++item_version_detail%0D%0Agroup+by+_item%29%0D%0AORDER+BY+percent_done+desc)

This repo archives the latest version of https://webapi.polizei.hessen.de/api/traffic/ every twenty minutes, if it has changed.

## Inspired By

Background on this project by Simon Willison: https://simonwillison.net/2020/Oct/9/git-scraping/

# Installation

```
pip install datasette git-history
```

Then import into sqlite file
```
./import.sh # which is basically git-history
```

Then start datasette to spin up webserver to query the data via browser
```
datasette de-he-pl-traffic.db
```
```
