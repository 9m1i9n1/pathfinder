package com.douzone.bit.pathfinder.service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.douzone.bit.pathfinder.model.entity.UserTb;
import com.douzone.bit.pathfinder.repository.UserRepository;

@Service
public class AdminUserService {

    @Autowired
    private UserRepository userRepository;

    // branch read
    public Optional<UserTb> read(Long id) {

        return userRepository.findById(id);
    }

    // user page
    public List<UserTb> search(Pageable pageable) {

        Page<UserTb> users = userRepository.findAll(pageable);

        System.out.println(users);
        List<UserTb> userList = users.stream().collect(Collectors.toList());

        return userList;
    }

    public int delete(Long id) {
        Optional<UserTb> optional = userRepository.findById(id);

        return optional.map(user -> {
            userRepository.delete(user);
            return 1;
        }).orElseGet(() -> 0);
    }
}