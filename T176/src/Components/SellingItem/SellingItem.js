import React, { useEffect, useState } from 'react'
import { useHistory } from 'react-router-dom';
import { useStateValue } from '../../StateProvider';
import './SellingItem.css'


const SellingItem = () => {

    const [{ user }, dispatch] = useStateValue();
    const history = useHistory();

    return (
        <div className='sellingItem'>
            <h2 style={{ color: 'black', fontWeight: '600', letterSpacing: '4px' }}>Congratulations <strong>{user?.email}</strong> your item is saved with us </h2>

            <button className='sellingItem__button' onClick={() => history.push('/sell')}>Go Back to Sell Page</button>

            <button className='sellingItem__button' onClick={() => history.push('/buyorsell')}>Go Back to Main Page</button>
        </div>
    )
}

export default SellingItem
