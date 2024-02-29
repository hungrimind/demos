import React, { useState } from "react";

export const Button: React.FC = () => {
  const [count, setCount] = useState(0);
  return (
    <button
      className="bg-zinc-500 hover:bg-zinc-700 text-white font-bold py-2 px-4 rounded"
      onClick={() => {
        switch (count) {
          case 0:
            alert("Oh yea baby! Click me again!");
            setCount(count + 1);
            break;
          case 1:
            alert("You click me soooo good!");
            setCount(count + 1);
            break;
          case 2:
            alert("Woah you're getting a little too spicy with me!");
            setCount(count + 1);
            break;
          default:
            alert(`We're done. You clicked me too hard.`);
            break;
        }
      }}
    >
      {count < 3 ? "Click me, baby!" : "😒😒😒"}
    </button>
  );
};
