import React, { useState, Component } from "react";
import axios from "axios";
import {
    Chart as ChartJS,
    CategoryScale,
    LinearScale,
    PointElement,
    LineElement,
    Title,
    Tooltip,
    Legend,
  } from 'chart.js';
  import { Line } from 'react-chartjs-2';


ChartJS.register(
    CategoryScale,
    LinearScale,
    PointElement,
    LineElement,
    Title,
    Tooltip,
    Legend
  );
  
class WeeklyOverview extends Component { 
  constructor(props) {

    super(props);
    this.state = {
      weeklySelectionData: [],
    };
  }

  loadTdlists() {
    axios
      .get(`/api/org/${this.props.orgId}/weekly_overview`)
      .then((res) => {
        this.setState({ weeklySelectionData: res.data });
      })
      .catch((error) => console.log(error));
  }

  componentDidMount() {
    this.loadTdlists();
  }
   
  render() {

    var options = {
        responsive: true,
        plugins: {
          legend: {
            position: 'top',
          },
          title: {
            display: true,
            text: 'Check-in Overview',
          },
        },
      };
      
    var labels = this.state.weeklySelectionData['date'];

    var data = {
     labels,
     datasets: [
       {
         label: 'Green',
         data: this.state.weeklySelectionData['green'],
         borderColor: 'rgba(75, 192, 192)',
         backgroundColor: 'rgba(75, 192, 192, 0.5)',
       },
       {
         label: 'Yellow',
         data: this.state.weeklySelectionData['yellow'],
         borderColor: 'rgb(255, 206, 86)',
         backgroundColor: 'rgba(255, 206, 86, 0.5)',
       },
       {
        label: 'Red',
        data: this.state.weeklySelectionData['red'],
        borderColor: 'rgb(255, 99, 132)',
        backgroundColor: 'rgba(255, 99, 132, 0.5)',
      },
     ],
   };
    return (
      <div >
         <Line options={options} data={data}/>
         <div></div>
      </div>
    );
  }
}

export default WeeklyOverview;
