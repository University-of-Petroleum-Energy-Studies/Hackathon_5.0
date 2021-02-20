import React from 'react'
import './BuyorSell.css'

import { useHistory } from 'react-router-dom'

const BuyorSell = () => {

    const history = useHistory();

    const buy = () => {
        history.push('/buy')
    }

    const sell = () => {
        history.push('/sell')
    }

    return (
        <div className='buyorsell'>

            <div className="buyorsell__heading">
                <h1 className='buyorsell__h1'>Main Page</h1>
            </div>

            <div className="buyorsell__buttons">
                <button onClick={buy} className='buyorsell__buy'>Buy Crops</button>

                <button onClick={sell} className='buyorsell__sell'>Sell Crops</button>
            </div>


        </div>
    )
}

export default BuyorSell
