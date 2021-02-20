import React from 'react'
import Currencyformat from 'react-currency-format';
import { useHistory } from 'react-router-dom';
import { getBasketTotal } from '../../Reducer';
import { useStateValue } from '../../StateProvider';

import '../Subtotal/Subtotal.css';

const Subtotal = () => {
    const history = useHistory();
    const [{ basket }, dispatch] = useStateValue();

    return (
        <div className="subtotal">
            <p>
                Subtotal ({basket.length} items): <strong>INR {getBasketTotal(basket)}</strong>
            </p>
            {/* <Currencyformat
                renderText={(value) => (
                    <>
                    </>
                )}
                decimalScale={2}
                value={getBasketTotal(basket)}
                displayText={"text"}
                thousandSeperator={true}
                prefix={"INR "}
            /> */}

            <button onClick={e => history.push('/payment')}>Proceed to Checkout</button>
        </div>
    )
}

export default Subtotal