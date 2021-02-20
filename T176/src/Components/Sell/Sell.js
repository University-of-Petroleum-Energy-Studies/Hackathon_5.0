import React from 'react'
import './Sell.css'

import Dropdown from 'react-dropdown';
import 'react-dropdown/style.css';

const options = [
    'Paddy', 'Jowar', 'Bajra', 'Potato', 'Maize', 'Tomato', 'Moong', 'Urad'
];

const defaultOption = options[0];

const Sell = () => {

    const [capacity, setCapacity] = React.useState(null);
    const [price, setPrice] = React.useState(null);
    const [crop, setCrop] = React.useState(null);


    return (
        <div className='sell'>


            <h1>Sell Crops</h1>

            <form className='sell__form' action="">

                <img className='sell__formImage' src="https://image.freepik.com/free-vector/document-purchase-customer-purchaser-deal-buying-contract-bill-sale-written-selling-document-execution-sales-contract-concept_335657-226.jpg" alt="" />

                <div className="sell__crop">
                    <p className='sell__cropP'>Available Crops: </p>
                    <Dropdown className='sell__cropMenu' options={options} value={defaultOption} placeholder="Select an option" required />
                </div>

                <div className="sell__selectCrop">
                    <p className='sell__selectCropP'>Crop: </p>
                    <input type="text" placeholder="Enter the crop you want to sell ... " onChange={(e) => setCrop(e.target.value)} style={{ width: '33vw', height: '3vh' }} />
                </div>

                <div className="sell__capacity">
                    <p className='sell__capacityTitle'>Capacity(KG): </p>
                    <input className='sell__capacityInput' type="text" placeholder="Enter your capacity ..." onChange={(e) => setCapacity(e.target.value)} style={{ width: '33vw', height: '3vh' }} required />
                </div>

                <div className="sell__price">
                    <p className='sell__priceP'>Price / KG: </p>
                    <input type="text" placeholder='Enter your Price per KG ...' style={{ width: '33vw', height: '3vh' }} onChange={(e) => setPrice(e.target.value)} required />
                </div>

                <div className="sell__button">
                    <input type='submit' value='Submit' />
                </div>
            </form>

        </div>
    )
}

export default Sell
