import React from 'react'
import ReactDOM from 'react-dom'

function Maps() {
  return (
    <div>
      <form>
        <div>
          <label htmlFor="latitude">Latitude</label>
          <input type="number" id="latitude" name="latitude" />
        </div>

        <div>
          <label htmlFor="longitude">Longitude</label>
          <input type="number" id="longitude" name="longitude" />
        </div>

        <div>
          <button>Search</button>
        </div>
      </form>
    </div>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<Maps />, document.body.appendChild(document.createElement('div')))
})
