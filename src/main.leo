program uniland_v1.aleo {
    mapping is_voted: field => bool;
    mapping nodes: u128 => Node;
    mapping edge_votes: Edge => u32;
    mapping to_nodes: Edge => u128;
    mapping edge_avail: Edge => bool;

    record Vote {
        owner: address,
        sender: address,
        node_id: u128,
        mov: u8,
    }

    struct Voted {
        caller: address,
        node_id: u128,
    }

    struct Edge {
        node_id: u128,
        mov: u8,
    }

    struct Node {
        node_id: u128,
        from: Edge, // parent_id and mov
        state: u128,
        game_status: i8, // 0 for not end 1 for win -1 for lose 2 for draw
    }

    inline get_contract_onwer () -> address {
        return aleo1y2y8zt4aecdd4dfh2lvs38q2q9f7q57laamm4xaa9kyd7al57crq4lu9j6; // need to change to your own address
    }

    transition open_game (public start_id: u128) {
        // check if is owner
        assert_eq(self.caller, get_contract_onwer());
        return then finalize(start_id);
    }

    finalize open_game (start_id: u128) {
        // check if is exist
        let is_exist: bool = Mapping::contains(nodes, start_id);
        assert_eq(is_exist, false);

        let node: Node = Node {
            node_id: start_id,
            state: 7083711853891053158400u128,
            from: Edge {
                node_id: 0u128,
                mov: 0u8,
            },
            game_status: 0i8,
        };

        Mapping::set(nodes, start_id, node);
    }

    transition ai_move (public node_id: u128, public next_node_id: u128, new_state: u128, game_status: i8, human_mov: u8) {
        // check if is owner
        assert_eq(self.caller, get_contract_onwer());
        return then finalize(node_id, next_node_id, new_state, game_status, human_mov);
    }

    finalize ai_move (node_id: u128, next_node_id: u128, new_state: u128, game_status: i8, human_mov: u8) {
        // check node exist
        let parent: Node = Mapping::get(nodes, node_id);

        // check edge votes >= 1
        let edge: Edge = Edge {
            node_id: node_id,
            mov: human_mov,
        };
        let votes: u32 = Mapping::get_or_use(edge_votes, edge, 0u32);
        assert(votes >= 1u32);

        // create new node
        let son: Node = Node {
            node_id: next_node_id,
            state: new_state,
            from: edge,
            game_status: game_status,
        };
        Mapping::set(nodes, son.node_id, son);
        Mapping::set(to_nodes, edge, son.node_id);
    }


    // Client Operations
    transition vote (node_id: u128, mov: u8) -> Vote {
        let caller_vote: Vote = Vote {
            owner: get_contract_onwer(),
            sender: self.caller,
            node_id: node_id,
            mov: mov,
        };

        let voted: Voted = Voted {
            caller: self.caller,
            node_id: node_id,
        };

        let voted_hash: field = BHP256::hash_to_field(voted);

        let is_valid: bool = mov <= 63u8;
        assert(is_valid);

        let edge: Edge = Edge {
            node_id: node_id,
            mov: mov,
        };

        return caller_vote then finalize(node_id, voted_hash, edge);
    }

    finalize vote (node_id: u128, voted_hash: field, edge: Edge) {
        // check edge is valid
        let is_avail: bool = Mapping::get_or_use(edge_avail, edge, true);
        assert(is_avail && node_id != 0u128);

        // check if is voted
        let is_vote: bool = Mapping::get_or_use(is_voted, voted_hash, false);
        assert(!is_vote);

        // check exist & status is valid
        let node: Node = Mapping::get(nodes, node_id);
        assert(node.game_status == 0i8);

        // check the from edge must >= 2 votes
        let from_edge: Edge = node.from;
        let from_edge_votes: u32 = Mapping::get_or_use(edge_votes, from_edge, 0u32);
        assert((from_edge_votes >= 2u32) || (from_edge.node_id == 0u128));

        // set voted & edge_votes
        Mapping::set(is_voted, voted_hash, true);
        let votes: u32 = Mapping::get_or_use(edge_votes, edge, 0u32);
        Mapping::set(edge_votes, edge, votes + 1u32);
        // set from edge not avail
        Mapping::set(edge_avail, from_edge, false);
    }
}
