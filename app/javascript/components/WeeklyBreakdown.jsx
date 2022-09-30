import React, { useState, Component } from "react";
import axios from "axios";
import {
    Chart as ChartJS,
    RadialLinearScale,
    ArcElement,
    Tooltip,
    Legend,
  } from 'chart.js';

import { PolarArea } from 'react-chartjs-2';
  
ChartJS.register(RadialLinearScale, ArcElement, Tooltip, Legend);

class WeeklyBreakdown extends Component { 
  constructor(props) {

    super(props);
    this.state = {
      WeeklyPolarChartData: [],
    };
  }

  loadChartData() {
    axios
      .get(`/api/org/${this.props.orgId}/weekly_breakdown`)
      .then((res) => {
        this.setState({ WeeklyPolarChartData: res.data });
      })
      .catch((error) => console.log(error));
  }

  componentDidMount() {
    this.loadChartData();
  }
   
  render() {
    var options = {
        responsive: true,
        plugins: {
          legend: {
            position: 'bottom',
          },
          title: {
            display: true,
            text: 'Check-in Breakdown',
          },
        },
      };
      
    const data = {
        labels: ['Green', 'Yellow', 'Red'],
        datasets: [
          {
            label: 'Weekly Breakdown',
            data: this.state.WeeklyPolarChartData,
            backgroundColor: [
              'rgba(75, 192, 192, 0.5)',
              'rgba(255, 206, 86, 0.5)',
              'rgba(255, 99, 132, 0.5)',
            ],
            borderWidth: 1,
          },
        ],
      };
    return (
      <div>
         <PolarArea data={data} options={options}/> 
         
      </div>
    );
  }
}

export default WeeklyBreakdown;
