import React, { useEffect, useState } from 'react'
import { Link, useHistory } from 'react-router-dom';

import '../Payment/Payment.css'
import { useStateValue } from '../../StateProvider';
import CheckoutProduct from '../Checkout/CheckoutProduct/CheckoutProduct';
// import { CardElement, useElements, useStripe } from '@stripe/react-stripe-js';
import { getBasketTotal } from '../../Reducer';

import { db } from '../../firebase';
import { CardElement, useElements, useStripe } from '@stripe/react-stripe-js';
import axios from '../../axios';

const Payment = () => {

    const [{ basket, user }, dispatch] = useStateValue();
    const history = useHistory();

    const stripe = useStripe();
    const elements = useElements();

    const [error, setError] = useState(null);
    const [disabled, setDisabled] = useState(true);
    const [succeeded, setSucceeded] = useState(false);
    const [processing, setProcessing] = useState("");
    const [clientSecret, setClientSecret] = useState(true);

    const [address, setAddress] = useState("");

    useEffect(() => {
        // generate the special stripe secret which allows o charge a cutomer
        const getClientSecret = async () => {
            const response = await axios({
                method: 'post',
                url: `/payments/create?total=${getBasketTotal(basket) * 100}`
            });
            setClientSecret(response.data.clientSecret)
        }
        getClientSecret();
    }, [basket])

    const handleSubmit = async (event) => {
        //Stripe
        event.preventDefault();
        setProcessing(true);

        const payload = await stripe.confirmCardPayment(clientSecret, {
            payment_method: {
                card: elements.getElement(CardElement)
            }
        }).then(({ paymentIntent }) => {
            // Payment intent = payment confirmation

            db.collection('users')
                .doc(user?.uid)
                .collection('orders')
                .doc(paymentIntent.id)
                .set({
                    basket: basket,
                    amount: paymentIntent.amount,
                    created: paymentIntent.created
                })

            setSucceeded(true);
            setError(null);
            setProcessing(false);

            dispatch({
                type: 'EMPTY_BASKET'
            })

            history.replace('/orders');
        })
    }

    const handleChange = e => {
        //Listen for changes in the card element and display any errors as the customer types their card details
        setDisabled(e.empty);
        setError(e.error ? e.error.message : "");
    }

    const addressSet = (e) => {
        e.preventDefault();
        setAddress(e.target.value);
    }

    return (

        <div className='payment'>
            <div className='payment__container'>
                <h1>
                    Checkout (<Link to='/checkout'>{basket?.length} items</Link>)
                </h1>

                {/* Delivery Address */}
                <div className='payment__section'>
                    <div className='payment__title'>
                        <h3>Delivery Address</h3>
                    </div>

                    <div className='payment__address'>
                        <p>{user?.email}</p>
                        {/* <p>Allahabad</p> */}
                        <input type="text" placeholder="Enter Address" name="address" onChange={addressSet} />
                        <p>{address}</p>
                    </div>
                </div>

                {/* Review items */}
                <div className='payment__section'>
                    <div className='payment__title'>
                        <h3>Review items and delivery</h3>
                    </div>

                    <div className='payment__items'>
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

                {/* Payment method */}
                <div className='payment__section'>
                    <div className='payment__title'>
                        <h3>Payment method</h3>
                    </div>

                    <div className='payment__details'>


                        <form onSubmit={handleSubmit}>

                            <CardElement onChange={handleChange} />

                            <div className='payment__priceContainer'>
                                <h3 className='payment__priceContainerH3'>Order Total: INR {getBasketTotal(basket)}</h3>

                                <button disabled={processing || disabled || succeeded}>
                                    <span>{processing ? <p>Processing</p> : "Buy Now"}</span>
                                </button>
                            </div>


                            {error && <div>{error}</div>}
                        </form>

                    </div>
                </div>

            </div>
        </div>
    )
}

export default Payment