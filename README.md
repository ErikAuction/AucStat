# AucStat

A simple test rails project for displaying auto dealer auction data.
 Clone the [AucStat](https://github.com/ErikAuction/AucStat) Project.

## Live Demo
  A live demo of the AucStat app:  [AucStat Live Demo](https://aucstat.herokuapp.com/)

## Dependencies

(on Ubuntu / Mac OS)
```
The Ruby language – version 2.2.2 or greater 
The Rails gem – version 5.0
```

## Installation

```
git clone https://github.com/ErikAuction/AucStat.git
cd AucStat
bundle
rake db:schema:load
```

## Run

```
run 'rails server' from the 'aucstat' directory 

browse to http://localhost:3000
```

## Usage
  After loading webpage, click on the "choose file" button to select a CSV file to import, and choose "Import CSV" to import the file
  example-data.csv has been provided in the root directory 
  
  Once the file has been imported, a simple auction listing with city name should be displayed.
  Clicking on any one of the auction names will bring up a detail pane for that auction 

  Selecting the "All Stats" option in the navbar will present a table display of all auctions and pertinent data 


## Example Auction Input Data
![example auction input data](/example.png "Example Auction Input Data")

