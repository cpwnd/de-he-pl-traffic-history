# TODO this could also be imported via class definitions from remote namespace

git-history file ffm-parking.db parkdaten_dyn.xml --convert 'tree = xml.etree.ElementTree.fromstring(content)
areas = []
facilities = []
strict = False

def e(el, k):
    _r = el.find("{http://datex2.eu/schema/2/2_0}" + k)
    if _r is None:
        raise ValueError("No value for " + k)
    return _r

# TODO don t skip whole batch, when attribute error is invoked
try:
    if len(tree) < 2 or len(tree[1]) < 4 or len(tree[1][3]) == 0:
        print("No value in xml contents")
        if strict:
            raise ValueError("No value in xml contents")
        return areas + facilities
    
    for el in tree[1][3][0].findall("{http://datex2.eu/schema/2/2_0}parkingAreaStatus"):
        try:
            areas.append({"id": e(el, "parkingAreaReference").get("id"),\
            "type": "area",\
            "statusTime": e(el, "parkingAreaStatusTime").text,\
            "occupancy": e(el, "parkingAreaOccupancy").text,\
            "totalParkingCapacityLongTermOverride": e(el, "totalParkingCapacityLongTermOverride").text,\
            "totalParkingCapacityShortTermOverride": e(el, "totalParkingCapacityShortTermOverride").text,\
            "vacant": e(el, "parkingAreaTotalNumberOfVacantParkingSpaces").text})
        except ValueError as e:
            print(e)
            if strict:
                raise

    for el in tree[1][3][0].findall("{http://datex2.eu/schema/2/2_0}parkingFacilityStatus"):
        try:
            facilities.append({"id": e(el, "parkingFacilityReference").get("id"), \
            "type": "facility", \
            "statusTime": e(el, "parkingFacilityStatusTime").text, \
            "occupancy": e(el, "parkingFacilityOccupancy").text, \
            "totalNumberOfOccupiedParkingSpaces": e(el, "totalNumberOfOccupiedParkingSpaces").text, \
            "totalParkingCapacityLongTermOverride": e(el, "totalParkingCapacityLongTermOverride").text, \
            "totalParkingCapacityShortTermOverride": e(el, "totalParkingCapacityShortTermOverride").text, \
            "vacant": e(el, "totalNumberOfVacantParkingSpaces").text})
        except ValueError as _e:
            print(_e)
            if strict:
                raise

except (AttributeError, IndexError) as e:
    print(e)
    raise

return areas + facilities
' --id id --id type --import xml.etree.ElementTree
