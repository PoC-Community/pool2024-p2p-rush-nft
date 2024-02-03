import './App.css';
import Home from './Page/Home.tsx';
import Header from './Component/Header.tsx';
import Footer from './Component/Footer.tsx';

function App() {
  return (
    <div id='app'>
      <Header />
      <Home />
      <Footer />
    </div>
  );
}

export default App;
