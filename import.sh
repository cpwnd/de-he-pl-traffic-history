# TODO this could also be imported via class definitions from remote namespace

git-history file de-he-pl-traffic.db traffic.json \
  --id id \
  --id dataId \
  --convert 'from functools import reduce
data = json.loads(content)
if data.get("status") != "OK":
    # {"code": 500, "error": "Error accessing remote data..."}
    return
for item in data["data"]:
    if data is None:
        continue
    try:
        res = dict()
        res["id"] = item["ticId"]["value"]
        res["producer"] = item["dataProducer"]["value"]
        res["dataId"] = item["dataIdentifier"]["value"]
        res["verbal"] = item["description"][0]["value"]
        res["urgency"] = item["urgency"]["value"]
        res["duration"] = item["duration"] if "duration" in item.keys() else None
        res["streets"] = None
        if "location" in item.keys() and "streets" in item["location"] and item["location"]["streets"]:
            res["streets"] = reduce(lambda a, b: a + "," + b, sorted(list(map(lambda x: x, list(item["location"]["streets"])))))

        res["durationStartTime"] = None
        res["durationEndTime"] = None
        if "duration" in item.keys() and item["duration"]:
            if "startTime" in item["duration"].keys():
                res["durationStartTime"] = item["duration"]["startTime"]["value"]
            if "endTime" in item["duration"].keys():
                res["durationEndTime"] = item["duration"]["endTime"]["value"]

        res["startTime"] = item["duration"]["startTime"]
        res["eventCategory"] = reduce(lambda a, b: a + "," + b, sorted(list(map(lambda x: x["value"], item["eventCategory"]))))
        res["begin"] = item["objectVersionBeginTime"]["value"]
        res["status"] = item["objectVersionStatus"]["value"]
        yield res
    except TypeError as e:
        print(e)
        continue
'
