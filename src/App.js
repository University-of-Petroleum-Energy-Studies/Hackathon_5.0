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

        </Switch>

      </div>
    </Router>
  );
}

export default App;
