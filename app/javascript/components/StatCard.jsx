import React, { useState, Component } from "react";
import axios from "axios";

class StatCard extends Component {  
    constructor(props) {
        super(props);
        this.state = {
          checkIns: {
              teamId: null, 
              numberOfCheckIns: null
          },
        };
      }

    fetchCardData() {
    axios
        .get(`/api/org/${this.props.orgId}/${this.props.type}_team`)
        .then((res) => {
        this.setState({ checkIns: res.data });
        })
        .catch((error) => console.log(error));
    }

    componentDidMount() {
    this.fetchCardData();
    }
render() {
    
  const style = {
    card: `relative flex flex-col border-2 border-gray-200 rounded-lg`,
    cardBody: `block flex-grow flex-shrink`,
    cardTitle: `font-medium text-gray-700 mb-8 text-center `,
    cardText: `text-stone-900`,
  };
  
  const inlineStyle = {
    boxShadow: '0 2px 5px 0 rgb(0 0 0 / 16%), 0 2px 10px 0 rgb(0 0 0 / 12%)',
    padding: '2rem',
    backgroundColor: 'rgba(75, 192, 192, 0.5)'
  };

  if (this.props.type == 'red') {
    inlineStyle['backgroundColor'] = 'rgba(255, 99, 132, 0.5)'
  }

  const inlineStyleTitle = {
    paddingBottom: '1.5rem',
    textColor: 'text-stone-900'
  }

  const inlineStyleText = {
    paddingBottom: '0.5rem',
    textColor: 'text-stone-900'
  }
  
  function Card({ children }) {
    return (
      <div className={style.card} style={inlineStyle}>
        {children}
      </div>
    );
  }
  
  function CardBody({ children }) {
    return <div className={style.cardBody} >{children}</div>;
  }
  
  function CardTitle({ children }) {
    return <div className={style.cardTitle} style={inlineStyleTitle}>{children}</div>;
  }
  
  function CardText({ children }) {
    return <div className={style.cardText} style={inlineStyleText}>{children}</div>;
  }


return (
  <div style={{width:'30%', display:'inline-block', margin: '1rem'}}>
      <Card>
        <CardBody>
          <CardTitle>Most {this.props.type.charAt(0).toUpperCase() + this.props.type.slice(1)} Team</CardTitle>
          <CardText>
           {this.state.checkIns.teamId}
           </CardText>
           <CardText>
           Check-ins: {this.state.checkIns.numberOfCheckIns}
          </CardText>
        </CardBody>
      </Card>
    </div>
)}}
export default StatCard;
