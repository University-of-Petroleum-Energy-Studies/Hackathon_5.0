import React from 'react'
import './Order.css'

import moment from 'moment';
import CheckoutProduct from '../../Checkout/CheckoutProduct/CheckoutProduct';
import CurrencyFormat from 'react-currency-format'

const Order = ({ order }) => {
    return (
        <div className='order'>

            <h2 style={{ color: 'black', textDecoration: 'underline', fontSize: '20px' }}>Your Orders</h2>

            <p><strong style={{ textDecoration: 'underline' }}>Date</strong> - {moment.unix(order.data.created).format('MMMM Do YYYY, h:mma')}</p>

            <p className='order__id'>
                <small><strong style={{ textDecoration: 'underline' }}>Order ID</strong> - {order.id}</small>
            </p>

            {order.data.basket?.map(item => (
                <CheckoutProduct
                    id={item.id}
                    title={item.title}
                    image={item.image}
                    price={item.price}
                    rating={item.rating}
                    hideButton
                />
            ))}

            <CurrencyFormat
                renderText={(value) => (
                    <h3 className='order__total'>
                        Order Total: {value}
                    </h3>
                )}
                decimalScale={2}
                value={order.data.amount / 100}
                displayType={"Text"}
                thousandSeperator={true}
                prefix={"INR"}
            />
        </div>
    )
}

export default Order
