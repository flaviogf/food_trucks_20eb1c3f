import React, { useEffect, useState } from 'react'
import ReactDOM from 'react-dom'
import { MapContainer, TileLayer, Marker, Popup, Circle, useMapEvents } from 'react-leaflet'
import axios from 'axios'

const accessToken = 'pk.eyJ1IjoiZmxhdmlvZ2YiLCJhIjoiY2tyOTVjM3JxMHdmNzJvbmk4YW9qZTk3OCJ9.z92E7oB6wMn2YQGLoukDbw'

const initialPosition = [37.7749, -122.4194]

function Maps() {
  const [longitude, setLongitude] = useState(initialPosition[1])
  const [latitude, setLatitude] = useState(initialPosition[0])
  const [foodTrucks, setFoodTrucks] = useState([])

  useEffect(() => {
    fetchFoodTrucks({ longitude, latitude })
  }, [])

  function onSubmit(e) {
    e.preventDefault()

    fetchFoodTrucks({ longitude, latitude })
  }

  function fetchFoodTrucks(params) {
    axios.get('api/v1/food_trucks', { params })
         .then(res => setFoodTrucks(res.data))
         .catch(console.error)
  }

  return (
    <div className="maps">
      <MapContainer center={initialPosition} zoom={13} scrollWhenZoom={false} style={{ height: '100%', width: '100%' }}>
        <TileLayer
          attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
          url={`https://api.mapbox.com/styles/v1/mapbox/light-v10/tiles/{z}/{x}/{y}?access_token=${accessToken}`}
        />

        <LocationCircle
          latitude={latitude}
          longitude={longitude}
          setLatitude={setLatitude}
          setLongitude={setLongitude}
        />

        {foodTrucks.map((it, index) => (
          <Marker key={String(index)} position={[it.latitude, it.longitude]}>
            <Popup>{it.food_items}</Popup>
          </Marker>
        ))}
      </MapContainer>

      <form className="maps__form" onSubmit={onSubmit}>
        <div className="maps__form-group">
          <label>Longitude: <input value={longitude} onChange={e => setLongitude(e.target.value)} type="number" /></label>
        </div>

        <div className="maps__form-group">
          <label>Latitude: <input value={latitude} onChange={e => setLatitude(e.target.value)} type="number" /></label>
        </div>

        <div>
          <button className="maps__button">Search</button>
        </div>
      </form>
    </div>
  )
}

function LocationCircle({ latitude, longitude, setLatitude, setLongitude }) {
  const map = useMapEvents({
    click(e) {
      setLongitude(e.latlng.lng)
      setLatitude(e.latlng.lat)
    },
  })

  return <Circle center={[latitude, longitude]} radius={2000} />
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<Maps />, document.body.appendChild(document.createElement('div')))
})
