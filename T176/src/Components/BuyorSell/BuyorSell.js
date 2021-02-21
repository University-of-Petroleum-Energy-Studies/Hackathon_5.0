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
                <h1 className='buyorsell__h1'>Welcome to <strong>AgriVend</strong></h1>
            </div>



            <div className="buyorsell__cards">
                <div class="card" onClick={buy}>
                    <img src="https://images.unsplash.com/photo-1472141521881-95d0e87e2e39?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=752&q=80" alt="Avatar" style={{ width: '100%', padding: '10px' }} />
                    <div class="container">
                        <h4><b>Buy Goods</b></h4>
                    </div>
                </div>

                <div class="card" onClick={sell}>
                    <img src="https://images.unsplash.com/photo-1461354464878-ad92f492a5a0?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=750&q=80" alt="Avatar" style={{ width: '100%', padding: '10px' }} />
                    <div class="container">
                        <h4><b>Sell Crops</b></h4>
                    </div>
                </div>
            </div>

        </div>
    )
}

export default BuyorSell
