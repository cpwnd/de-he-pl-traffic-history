# TODO this could also be imported via class definitions from remote namespace

git-history file de-he-pl-traffic.db traffic.json \
  --id id \
  --id dataId \
  --convert 'data = json.loads(content)
if data.get("status") != "OK":
    # {"code": 500, "error": "Error accessing remote data..."}
    return
for item in data["data"]:
    res = dict()
    res["id"] = item["ticId"]["value"]
    res["producer"] = item["dataProducer"]["value"]
    res["dataId"] = item["dataIdentifier"]["value"]
    res["verbal"] = item["description"][0]["value"]
    res["urgency"] = item["urgency"]["value"]
    res["eventCategory"] = item["eventCategory"][0]["value"]
    res["begin"] = item["objectVersionBeginTime"]["value"]
    res["status"] = item["objectVersionStatus"]["value"]
    yield res
'
