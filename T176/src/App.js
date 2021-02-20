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

function App() {

  return (
    <Router>
      <div className="app">

        <Switch>

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

        </Switch>

      </div>
    </Router>
  );
}

export default App;
