import React from 'react'
import './Product.css'
import { useStateValue } from '../../StateProvider';

const Product = ({ id, title, image, price, rating }) => {

    const [{ basket, user }, dispatch] = useStateValue();

    const addToBasket = () => {
        dispatch({
            type: "ADD_TO_BASKET",
            item: {
                id: id,
                title: title,
                image: image,
                price: price,
                rating: rating,
                user: user?.email
            }
        })
    }

    return (
        <div className='product'>

            <div className='product__info'>
                <p>{title}</p>
                <p className='product__price'>
                    <small>INR </small>
                    <strong>{price}</strong>
                </p>
            </div>

            <div className='product__rating'>
                {Array(rating).fill().map((_, i) => (
                    <p className='product__stars'>★</p>
                ))}
            </div>

            <img src={image} alt='' />
            <button onClick={addToBasket}>Add to basket</button>

        </div>
    )
}

export default Product
