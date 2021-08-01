# Project

## Architecture

<p align="center">
  <img src=".github/architecture.png">
</p>

## How to use

```sh
# Clone repository
git clone https://github.com/flaviogf/food_trucks_20eb1c3f.git

# Enter in project directory
cd food_trucks_20eb1c3f

# Start redis, elasticsearch and kibana first
docker-compose up -d redis elasticsearch kibana

# Create food-trucks-v1 index
curl -XPUT 'localhost:9200/food-trucks-v1' -H 'Content-Type: application/json' -d '{
  "mappings": {
    "properties": {
      "food_items": {
        "type": "text"
      },
      "location": {
        "type": "geo_point"
      }
    }
  }
}'

# Start web and job
docker-compose up -d web job

# It will be running at http://localhost:3000
```
