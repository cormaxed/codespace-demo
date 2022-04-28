/* eslint-disable react/jsx-key */
import * as React from "react";
import type { NextPage } from "next";
import { gql } from "@apollo/client";
import client from "../apollo/apollo-client";

interface HitSingleData {
  billboard_single_by_year: HitSingle[];
}

interface HitSingle {
  position: number;
  title: string;
  artist: string;
  year: number;
}

export async function getServerSideProps(context) {
  const { data } = await client.query<HitSingleData>({
    query: gql`
      query billboard_single_by_year_ordered {
        billboard_single_by_year(order_by: { position: asc }) {
          position
          title
          artist
          year
        }
      }
    `,
  });

  return {
    props: {
      hits: data,
    },
  };
}
const tableStyle = {
  border: "1px solid black",
  width: "100%",
};

const Home: NextPage = ({ hits }) => {
  const tableRows = hits.billboard_single_by_year.map((hit: HitSingle) => (
    <tr key="{hit.position}">
      <td>{hit.position}</td>
      <td>{hit.title}</td>
      <td>{hit.artist}</td>
      <td>{hit.year}</td>
    </tr>
  ));
  return (
    <div>
      <h1>Billboard Top 10 Songs Of 1980</h1>
      <table style={tableStyle}>
        <thead>
          <tr>
            <th>Position</th>
            <th>Title</th>
            <th>Artist</th>
            <th>Year</th>
          </tr>
        </thead>
        <tbody>{tableRows}</tbody>
      </table>
    </div>
  );
};

export default Home;
