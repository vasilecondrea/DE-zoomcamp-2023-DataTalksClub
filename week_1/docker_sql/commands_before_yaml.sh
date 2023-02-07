

docker network create pg-network

docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5433:5432 \
  --network=pg-network \
  --name pg-database \
  postgres:13

  docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -p 8080:80 \
  --network=pg-network \
  --name pgadmin2 \
  dpage/pgadmin4

# variable containig the source of the file which will be used for query
  URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz"

#start the pipeline to ingest the data into the databasse
python ingest_data.py \
  --user=root \
  --password=root \
  --host=localhost \
  --port=5433 \
  --db=ny_taxi \
  --table_name=yellow_taxi_trips \
  --url=${URL}

# now you can check in pgadmin that the database has been succesfully populated.

# Modify the file ingest_data.py appropriately and then

# build the image from the modified docker file

docker build -t taxi_ingest:v001 .


# after building docker run the above following the template of the python comand above
# be careful to run it in the network with   --network=pg-network \ as the first optoin
docker run -it \
  --network=pg-network \
taxi_ingest:v001 \
  --user=root \
  --password=root \
  --host=pg-database \
  --port=5433 \
  --db=ny_taxi \
  --table_name=yellow_taxi_trips \
  --url=${URL}