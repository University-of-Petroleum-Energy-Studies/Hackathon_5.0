import React from 'react'
import { useStateValue } from '../../StateProvider';

import '../Checkout/Checkout.css';
import Subtotal from '../Subtotal/Subtotal';
import CheckoutProduct from './CheckoutProduct/CheckoutProduct';

const Checkout = () => {
    const [{ basket, user }, dispatch] = useStateValue();

    return (
        <div className='checkout'>
            {/* Left */}
            <div className='checkout__left'>
                <div>
                    <h3>{user ? `Hello ${user.email}` : ""}</h3>
                    <h2 className='checkout__title'>Your Shopping Basket</h2>

                    {/* CheckoutProduct */}
                    {basket.map(item => (
                        <CheckoutProduct
                            id={item.id}
                            title={item.title}
                            image={item.image}
                            price={item.price}
                            rating={item.rating}
                        />
                    ))}
                </div>
            </div>

            {/* Right */}
            <div className='checkout__right'>
                {/* Subtotal */}
                <Subtotal />
            </div>
        </div>
    )
}

export default Checkout