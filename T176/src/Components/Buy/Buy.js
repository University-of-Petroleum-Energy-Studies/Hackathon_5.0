import React from 'react'
import Product from '../Product/Product'
import './Buy.css'

const Buy = () => {
    return (
        <div className='buy'>


            <div className='home__container'>
                <img className='home__image' src="https://images.unsplash.com/photo-1560321941-84a23c5fce8c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80" alt="" />


                <div className='home__row'>
                    {/* <h2 className='buy__heading'>Fertilizers</h2> */}
                    <Product
                        id="1"
                        title="TrustBasket Organic Vermicompost Fertilizer Manure for Plants - 5 KG"
                        price={299}
                        image="https://m.media-amazon.com/images/I/71iPA5LfB7L._AC_UL320_.jpg"
                        rating={5}
                    />
                    <Product
                        id="2"
                        title="Trust basket Enriched Organic Earth Magic Potting Soil Fertilizer for Plants, 5 kg"
                        price={299}
                        image="https://m.media-amazon.com/images/I/61fUoGkNdHL._AC_UL320_.jpg"
                        rating={4}
                    />

                    <Product
                        id="2"
                        title="Go Garden NPK 19 19 19 Fertilizer for Plants and Gardening Purpose (450G)"
                        price={199}
                        image="https://m.media-amazon.com/images/I/71t4fa+-XHL._AC_UL320_.jpg"
                        rating={4}
                    />

                </div>

                <div className='home__row'>
                    {/* <div className="home__heading">
                        <h2>Equipments</h2>
                    </div> */}

                    <Product
                        id="3"
                        title="John Deere 5310 4WD"
                        price={100000}
                        image="https://www.tractorjunction.com/assets/images/upload/john-deere-5310-4wd-985351.png"
                        rating={5}
                    />
                    <Product
                        id="4"
                        title="Kartar 4000"
                        price={247000}
                        image="https://www.tractorjunction.com/assets/images/images/implementTractor/40009999.jpg"
                        rating={5}
                    />
                    <Product
                        id="5"
                        title="VISHWAKARMA Mild Steel YUG-15 Model Cultivator, More Than 40 Hp"
                        price={24500}
                        image="https://5.imimg.com/data5/UL/CE/UO/SELLER-288604/yug-15-model-cultivator-500x500.jpg"
                        rating={5}
                    />
                </div>

                <div className='home__row'>
                    {/* <div className="home__heading">
                        <h2>Seeds</h2>
                    </div> */}

                    <Product
                        id="6"
                        title="Wasabinoki Seeds"
                        price={600}
                        image="https://5.imimg.com/data5/VP/MG/MY-3966004/wasabinoki-seeds-500x500.jpg"
                        rating={5}
                    />

                    <Product
                        id="6"
                        title="Gliricidia Sepium"
                        price={400}
                        image="https://5.imimg.com/data5/DP/DI/MY-2072454/gliricidia-sepium-500x500.jpg"
                        rating={5}
                    />

                    <Product
                        id="6"
                        title="Saffron Seeds"
                        price={1450}
                        image="https://5.imimg.com/data5/TV/GS/MY-23290214/saffron-seeds-500x500.jpeg"
                        rating={5}
                    />

                </div>
            </div>




        </div>
    )
}

export default Buy
