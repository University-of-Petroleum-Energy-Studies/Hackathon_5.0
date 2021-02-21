import './App.css';
import Login from './Components/Login/Login'
import Register from './Components/Register/Register'
import Home from './Components/Home/Home';

import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link
} from "react-router-dom";
import BuyorSell from './Components/BuyorSell/BuyorSell';
import Buy from './Components/Buy/Buy';
import Header from './Components/Header/Header';
import Checkout from './Components/Checkout/Checkout';
import Payment from './Components/Payment/Payment';
import Sell from './Components/Sell/Sell';
import { useEffect } from 'react';
import { auth } from './firebase';
import { useStateValue } from './StateProvider';

import { loadStripe } from '@stripe/stripe-js';
import { Elements } from '@stripe/react-stripe-js';
import Orders from './Components/Order/Orders';
import SellingItem from './Components/SellingItem/SellingItem';


const promise = loadStripe("pk_test_51HlsqsEJTBWipWhA6UIua1R9qKRQREaPlfN3LAXzfGVgQsUS0ih6E88edf3Fwd1uvAouB6KI7W1shuN5bg8xDedO00jTJMiHMh");

function App() {

  const [{ basket, user }, dispatch] = useStateValue();

  useEffect(() => {
    // will only run once when the app component loads
    auth.onAuthStateChanged(authUser => {
      if (authUser) {
        dispatch({
          type: 'SET_USER',
          user: authUser
        })
      } else {
        dispatch({
          type: 'SET_USER',
          user: null
        })
      }
    })
  }, [])

  return (
    <Router>
      <div className="app">

        <Switch>

          {
            (user) ? (
              <>
                <Route exact path="/">
                  <Home />
                </Route>

                <Route exact path="/login">
                  <Login />
                </Route>

                <Route exact path="/register">
                  <Register />
                </Route>

                <Route exact path="/buyorsell">
                  <BuyorSell />
                </Route>

                <Route exact path="/buy">
                  <Header />
                  <Buy />
                </Route>

                <Route exact path="/checkout">
                  <Header />
                  <Checkout />
                </Route>

                <Route exact path="/payment">
                  <Elements stripe={promise}>
                    <Payment />
                  </Elements>

                </Route>

                <Route exact path="/sell">
                  <Sell />
                </Route>

                <Route exact path="/orders">
                  <Header />
                  <Orders />
                </Route>

                <Route exact path="/sellingItem">
                  <SellingItem />
                </Route>

              </>
            ) : (
                <>
                  <Route exact path="/buy">
                    <Header />
                    <Buy />
                  </Route>

                  <Route exact path="/">
                    <Home />
                  </Route>

                  <Route exact path="/login">
                    <Login />
                  </Route>

                  <Route exact path="/register">
                    <Register />
                  </Route>
                </>
              )
          }

          {/* <Route exact path="/">
            <Home />
          </Route>

          <Route exact path="/login">
            <Login />
          </Route>

          <Route exact path="/register">
            <Register />
          </Route>

          <Route exact path="/buyorsell">
            <BuyorSell />
          </Route>

          <Route exact path="/buy">
            <Header />
            <Buy />
          </Route>

          <Route exact path="/checkout">
            <Header />
            <Checkout />
          </Route>

          <Route exact path="/payment">
            <Elements stripe={promise}>
              <Payment />
            </Elements>

          </Route>

          <Route exact path="/sell">
            <Sell />
          </Route>

          <Route exact path="/orders">
            <Header />
            <Orders />
          </Route>

          <Route exact path="/sellingItem">
            <SellingItem />
          </Route> */}

        </Switch>

      </div>
    </Router>
  );
}

export default App;
