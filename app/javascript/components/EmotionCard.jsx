import React, { useState, Component } from "react";
import axios from "axios";

class EmotionCard extends Component {  
    constructor(props) {
        super(props);
        this.state = {
          data: {},
          emotions: []
        };
      }

    fetchCardData() {
    axios
        .get(`/api/org/${this.props.orgId}/top_emotions`)
        .then((res) => {
        this.setState({ data: res.data });
        Object.keys(res.data).forEach(key => {
          this.state.emotions.push(<div> {key.charAt(0).toUpperCase() + key.slice(1)} -  {res.data[key]}</div>)
        })
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
    backgroundColor: 'rgba(255, 206, 86, 0.5)'
  };


  const inlineStyleTitle = {
    paddingBottom: '1rem',
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
    return <div className={style.cardText}>{children}</div>;
  }

 
 

return (
  <div style={{width:'30%', display:'inline-block', margin: '1rem'}}>
      <Card>
        <CardBody>
          <CardTitle>Most common Emotions</CardTitle>
          {this.state.emotions}
          <CardText>
           </CardText>
           <CardText>
          </CardText>
        </CardBody>
      </Card>
    </div>
)}}
export default EmotionCard;
