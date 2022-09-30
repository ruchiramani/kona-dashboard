import React, { useState, Component } from "react";
import WeeklyOverview from './WeeklyOverview.jsx';
import WeeklyBreakdown from "./WeeklyBreakdown.jsx";
import StatCard from './StatCard.jsx';
import EmotionCard from './EmotionCard.jsx';
class App extends Component { 
  constructor(props) {
    super(props);
    this.state = {
      tdlists: [],
    };
  }
  render() {
    return (
      <div>
      <div style={{ columnGap: '1rem', minHeight: '30rem'}} >
        <div style={{ display:'inline-block', width:'70%', height:'100px' }}>
          <WeeklyOverview orgId={this.props.orgId}/>
        </div>
        <div style={{ display:'inline-block', width:'30%', height:'100px'}}>
          <WeeklyBreakdown orgId={this.props.orgId}/>
        </div>
      </div>
      <div >
    
        <StatCard orgId={this.props.orgId} type={'green'}/>
        <StatCard orgId={this.props.orgId} type={'red'}/>
        <EmotionCard orgId={this.props.orgId}/>
      </div>
      </div>
    );
  }
}

export default App;
