import React from 'react'
import ReactDOM from 'react-dom'
import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet'

const accessToken = 'pk.eyJ1IjoiZmxhdmlvZ2YiLCJhIjoiY2tyOTVjM3JxMHdmNzJvbmk4YW9qZTk3OCJ9.z92E7oB6wMn2YQGLoukDbw'

const position = [37.7749, -122.4194]

function Maps() {
  return (
    <div class="maps">
      <MapContainer center={position} zoom={13} scrollWhenZoom={false} style={{ height: '100%', width: '100%' }}>
        <TileLayer
          attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
          url={`https://api.mapbox.com/styles/v1/mapbox/light-v10/tiles/{z}/{x}/{y}?access_token=${accessToken}`}
        />
        <Marker position={position}>
          <Popup>Center of San Francisco</Popup>
        </Marker>
      </MapContainer>
    </div>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<Maps />, document.body.appendChild(document.createElement('div')))
})
