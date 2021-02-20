import React, { createContext, useContext, useReducer } from 'react';

//Prepares the Data Layer
export const StateContext = createContext();

//Wrap the application and provide the data layer to every component
export const StateProvider = ({ reducer, initialState, children }) => (
    <StateContext.Provider value={useReducer(reducer, initialState)}>{children}</StateContext.Provider>
);

// Pull information from the data layer
export const useStateValue = () => useContext(StateContext);